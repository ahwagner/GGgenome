clin_data <- read.delim('ClinicalData.txt')

histcat_data <- clin_data[c(2, 8)]
brdeath_data <- clin_data[c(2, 28)]
anystat_data <- clin_data[c(2, 38)]
sCall_data <- clin_data[c(2, 41)]

histcat_data$histcat[histcat_data$histcat == 1] <- 'ductal'
histcat_data$histcat[histcat_data$histcat == 2] <- 'lobular'
histcat_data$histcat[histcat_data$histcat == 3] <- 'other'
colnames(histcat_data) <- c('samples', 'histology category')

brdeath_data$brdeath[brdeath_data$brdeath == 0] <- 'alive (uncensored)'
brdeath_data$brdeath[brdeath_data$brdeath == 1] <- 'death from breast cancer (event)'
brdeath_data$brdeath[brdeath_data$brdeath == 2] <- 'death from other than breast cancer (censored)'
brdeath_data$brdeath[brdeath_data$brdeath == 3] <- 'alive (censored)'
brdeath_data$brdeath[brdeath_data$brdeath == 9] <- 'unknown cause of death'
colnames(brdeath_data) <- c('samples', 'cause of death')

anystat_data$anystat[anystat_data$anystat == -1] <- 'M1 case'
anystat_data$anystat[anystat_data$anystat == 0] <- 'no relapse'
anystat_data$anystat[anystat_data$anystat == 1] <- 'any relapse'
colnames(anystat_data) <- c('samples', 'relapse status')

colnames(sCall_data) <- c('samples', 'subtype')

anystat_data <- melt(anystat_data, id.vars=c('samples'))
brdeath_data <- melt(brdeath_data, id.vars=c('samples'))
histcat_data <- melt(histcat_data, id.vars=c('samples')) 
sCall_data <- melt(sCall_data, id.vars=c('samples'))

clin_data <- rbind(sCall_data, histcat_data, brdeath_data, anystat_data)

clin_data$value[is.na(clin_data$value)] <- 'unknown'