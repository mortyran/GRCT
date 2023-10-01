setwd("C:\\Users\\acer\\Desktop\\westlake-university\\life-science-college\\rotation\\the-first-rotation\\tutorial\\LDSC-demo\\running")
library(corrplot)
library(reshape2)

cor_mat = matrix(NA, nrow = 3, ncol = 3)
colnames(cor_mat) = c("Asthma", "Ever smoke", "Lung cancer")
rownames(cor_mat) = c("Asthma", "Ever smoke", "Lung cancer")

diag(cor_mat) = 0

cor_mat[1,3] = 0.5772
cor_mat[3,1] = 0.5772

cor_mat[2,3] = 0.4276
cor_mat[3,2] = 0.4276

cor_mat[1,2] = 0.156
cor_mat[2,1] = 0.156

p_mat = matrix(NA, nrow = 3, ncol = 3)
colnames(p_mat) = c("Asthma", "Ever smoke", "Lung cancer")
rownames(p_mat) = c("Asthma", "Ever smoke", "Lung cancer")

diag(p_mat) = 0

p_mat[1,3] = 0.0379
p_mat[3,1] = 0.0379

p_mat[2,3] = 1.4804e-05
p_mat[3,2] = 1.4804e-05

p_mat[1,2] = 0.0166
p_mat[2,1] = 0.0166

cairo_pdf("corrplot_rg_disease.pdf", width = 8, height = 5, family = "Arial")
corrplot.mixed(cor_mat,
               lower = "number", 
               upper = "circle",
               tl.col = "black")
dev.off()

png("corrplot_rg_disease.png", width = 7.5, height = 4, units = 'in', res = 750, family = "Arial")
corrplot.mixed(cor_mat,
               lower = "number", 
               upper = "circle",
               tl.col = "black")
dev.off()

