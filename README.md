# experimental-design
central composite in experimental design - response surface model

#### Introduction

###### Aim of the study

There're tradeoffs among TiN peeling, tungsten film uniformity and tungsten film stress, where uniformity and stress were founded to be controlled by both pressure and H_2/WF_6 ratio, while the happening of peeling were impacted by ratio. Here in this study, the response surface methodology with central composite design has been applied, intend to find optimal combinations of  pressure and ratio to minimize uniformity and stress, as well as avoid TiN peeling.

###### Variables:

-- pressure: covariate, quantitative variable, ranges from 4 to 80

-- ratio: covariate, quantitative variable, ranges from 2 to 10

-- stress: quantitative variable, performing as response to be minimized 

-- uniformity: quantitative variable, performing as response to be minimized 

-- peeling: categorical variable, performing as response to represent the happenness of TiN peeling

###### Experimental Design

-- Central composite design

The design of experiments follows central composite design, where there're 4 factorial points, 4 star points as well as 3 center points, with $\alpha=\sqrt2$, therefore a rotatable design.

![image](https://user-images.githubusercontent.com/47954276/119771405-4571a100-be83-11eb-9ae7-b3792bf171aa.png)


#### Methodology

###### Quardic Response Surface Model

-- Response surface model is to explore the relationship between several exploratory variables and on or more response variables. Where the main idea is to use a sequence of designed experiments to obtain an optimal response, therefore can be used to optimize a process. While the quardic response surface model is to include both first order of predictors and quardic polynomial terms of predictors into a regression model. 

![image](https://user-images.githubusercontent.com/47954276/119771505-718d2200-be83-11eb-9d64-75b8a8579053.png)

###### Model Assumptions

-- Similar to  regression models, the response surface model assumes normality, independency and constant variance of error term

-- The response surface model assumes that all exploratory varibles are significant

-- A quardic response always has a stationary point, which can be either a min/max or saddle point

###### Analysis Plan

-- The design of experiments follows the central composite design. From the dataset, we can find that there're 4 factorial points, 4 star points and 3 center point, where the $\alpha=\sqrt2$, thus rotatable.

-- Fit two quardic response surface regression models with covariates pressure and ratio, where one it stress response and the other is for uniformity. Visualize the contours for stress and uniformity to find optimial combinations of pressure and ratio to minimize the stress and the uniformity.

-- Add three more data points into the exprimental design, then fit a classification model for peeling status with covariates pressure and ratio, find threshold of the classification model using linear discriminant analysis.


#### References

[Central Composite Design](https://online.stat.psu.edu/stat503/lesson/11/11.2/11.2.1)

[Discriminant Analysis](rpubs.com/mathetal/qda) 

[RSM in R](https://statacumen.com/teach/RSM/notes/RSM_notes_F14.pdf)

[RSM in R](https://cran.r-project.org/web/packages/rsm/vignettes/rsm.pdf)
