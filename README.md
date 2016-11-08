# PI-IRAP Shiny app

An R Shiny app to calculate PI-IRAP scores from IRAP data. 

The Implicit Relational Assessment Procedure (IRAP) is an indirect measure of implicit attitudes. IRAP effects are most commonly quantified using a variant of the D scoring algorithm (Greenwald et al., 2003). Here we propose an alternative scoring algorithm, the Probabilistic Index (PI: Thas et al., 2012). Using a gender IRAP dataset (N = 188), we demonstrate that it is more robust to the influence of outliers, which are very common in reaction time data. We also provide a Shiny app implementation of the PI-IRAP algorithm, as well as the R source code.

## License

Copyright (c) Ian Hussey 2015 (ian.hussey@ugent.be)

Released under the GPLv3+ open source license. 

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

## Version

0.1

## To do

1. Work on the notation and presentation of the app
2. Add overall PI overall score calculations (including for Cronbach's alpha)
3. Add D scores for comparison
4. Provide a link to Maarten's VB6 IRAP data cleaning scripts within the shiny app
5. Add PI calculation to Ian's Open Source IRAP R script, or a cleaning script to data from it work with the shiny app

## Reference

De Schryver, M., Hussey, I., De Neve, J., Cartwright, A., & Barnes-Holmes, D. (under review). The PI-IRAP: An alternative scoring algorithm for the IRAP using a more robust effect size measure. http://osf.io/4cmsm