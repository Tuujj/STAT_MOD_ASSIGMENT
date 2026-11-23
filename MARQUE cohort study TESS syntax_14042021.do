*Working out environment score (TESS) in the MARQUE cohort study
*Stata syntax written by Dr Louise Marston, Department of Primary Care and Population Health, University College London
*For sharing 14/04/2021
/*
Scoring the TESS from Bicket et al (2010) The physical environment influences neuropsychiatric
symptoms and other outcomes in assisted living residents
TESS-NH/RCa item Description and rating criteria
Facility maintenance Rated ‘in need of extensive repairs’, ‘in need of some repairs’, and ‘well maintained’ for scores of 0, 1, or 2,
respectively. Scores for activity/dining areas, halls, resident rooms and bathrooms averaged
Cleanliness Rated ‘poor level of cleanliness’, ‘moderately clean’, or ‘very clean’ using same strategy as facility maintenance
Handrails Rated ‘little or none’, ‘somewhat’, or ‘extensively’ for scores of 0, 1, or 2, respectively. Scores for halls and
bathrooms averaged
Call buttons Proportion of resident rooms and bathrooms with call buttons. Scores averaged
Light intensity Rated ‘barely adequate/inadequate’, ‘good’, or ‘ample’ for scores of 0, 1, or 2, respectively. Scores for hallways,
activity/dining areas and resident rooms averaged
Light glare Rated ‘in many areas’, ‘in a few areas’, or ‘a little or none’ using same strategy for light intensity
Light evenness Rated ‘uneven; many shadows’, ‘mostly even’, or ‘even’ using same strategy for light intensity
Hallway length Rated ‘long hallways’, ‘short hallways’, or ‘no hallways’ for scores of 0, 1, or 2, respectively
Homelikeness Reflecting (1) homelike furniture and other features in public areas, rated ‘not/somewhat homelike’, ‘moderately
homelike’, or ‘very homelike’ for scores of 0, 1, or 2, respectively; (2) proportion of homelike furniture in
resident rooms. Scores averaged
Room autonomy Proportion of resident rooms with independent heating controls, air conditioning, and doors that lock inside
and out. Scores averaged
Telephones Proportion of resident rooms with telephones
Tactile stimulation Reflecting availability of tactile stimulation in activity/dining areas and hallways, rated ‘none’, ‘somewhat/quite
a bit’, or ‘extensively’ for scores of 0, 1, or 2, respectively
Visual stimulation Reflecting availability of visual stimulation using same strategy for tactile stimulation
Privacy Proportion of resident rooms that are private, proportion of residents with private toilets, and proportion of
residents with private bath/shower facilities. Scores averaged
Outdoor area Reflecting (1) attractiveness and (2) functionality of outdoor area(s), rated ‘not at all’, ‘somewhat’, or ‘very’ for
scores of 0, 1, or 2, respectively. Scores averaged
aTESS-NH/RC¼Therapeutic Environment Screening Survey for Nursing Homes and Residential Care; scores may be 0, 1, or 2 with higher scores indicating
*/
*Calculating the TESS score
gen room_maintain=((tes_02c2*2+tes_02c1)/tes_02)
gen bath_maintain=((tes_02d2*2+tes_02d1)/tes_06)
gen maintain=(tes_02a+tes_02b+room_maintain+bath_maintain)/4
gen room_clean=(((tes_03c2*2)+tes_03c1)/tes_03)
gen bath_clean=(((tes_03d2*2)+tes_03d1)/tes_07)
gen clean=(tes_03a+tes_03b+room_clean+bath_clean)/4
gen bath_handrail=(((tes_06b2*2)+tes_06b1)/tes_06no)
gen handrails=(tes_06a+bath_handrail)/2
gen room_call=(tes_07a/tes_07c)
gen bath_call=(tes_07b/tes_07bd)
gen call=(room_call+bath_call)/2
gen room_intens=((tes_10c2*2+tes_10c1)/tes_11)
gen light_intens=(tes_10b+tes_10a+room_intens)/3
gen room_glare=(((tes_11c2*2)+tes_11c1)/tes_12)
gen light_glare=(tes_11b+tes_11a+room_glare)/3
gen room_even=((tes_12c2*2+tes_12c1)/tes_13)
gen light_even=(tes_12b+tes_12a+room_even)/3
gen home_room=(tes_17/ tes_17no)
gen homelike=(tes_16+home_room)/2
gen room_heat=tes_18b/ tes_18no
gen room_ac=tes_18c/ tes_18no
gen room_lockin=tes_24a/ tes_24no
gen room_lockout=tes_24b/ tes_24no
gen room_autonomy=(room_heat+ room_ac+ room_lockin+ room_lockout)/4
gen room_phone=tes_18d/ tes_18no
gen room_private=tes_24/ tes_21no
gen room_toilet=tes_22a/ tes_22no
gen room_bath=tes_23a/ tes_23no
gen privacy=(room_private+room_toilet+room_bath)/3
gen garden=(tes_29a+ tes_29b)/2

gen tess_score=maintain+clean+handrails+call+light_intens+tes_14+homelike+room_autonomy+room_phone+tes_19a+ tes_19b+privacy+garden
