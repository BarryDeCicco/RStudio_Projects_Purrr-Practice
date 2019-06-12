# File 2 - Using _apply

lapply(Affairs[c("affairs", "age", "yearsmarried")], 
       function(x) t.test(x ~ Affairs$gender))