---
title: "Dashboard"
output: 
  flexdashboard::flex_dashboard:
    vertical_layout: scroll
    orientation: rows
    social: ["menu"]
    theme: yeti
---

This kernel aims to provide some basic interactive visualizations of each molecule type in the dataset.

Feel free to use this kernel for your own work.

.

``` {js}
$('.navbar-inverse').removeClass('navbar-inverse').addClass('navbar-default');
```

```{r setup, include=FALSE}
library(data.table)
library(flexdashboard)
library(ggplot2)
library(highcharter)

train <- fread("../input/train.csv")
test <- fread("../input/test.csv")

structures_0 <- fread("../input/structures.csv")
structures_1 <- copy(structures_0)

setnames(structures_0, names(structures_0)[-1], paste0(names(structures_0)[-1], "_0"))
setnames(structures_1, names(structures_1)[-1], paste0(names(structures_1)[-1], "_1"))

setnames(structures_0, names(structures_0)[-c(1:2)], paste0("structure_", names(structures_0)[-c(1:2)]))
setnames(structures_1, names(structures_1)[-c(1:2)], paste0("structure_", names(structures_1)[-c(1:2)]))

train <- merge(train, structures_0, all.x = T, by = c("molecule_name", "atom_index_0"))
train <- merge(train, structures_1, all.x = T, by = c("molecule_name", "atom_index_1"))

test <- merge(test, structures_0, all.x = T, by = c("molecule_name", "atom_index_0"))
test <- merge(test, structures_1, all.x = T, by = c("molecule_name", "atom_index_1"))

train[, data_flag := "train"]
test[, data_flag := "test"]

train[, atom_dist := sqrt((structure_x_0 - structure_x_1) ^ 2 + (structure_y_0 - structure_y_1) ^ 2 + (structure_z_0 - structure_z_1) ^ 2)]

train_test <- rbind(train, test, use.names = T, fill = T)
train_test[, ":="(atom_index_0 = as.factor(atom_index_0),
                  atom_index_1 = as.factor(atom_index_1),
                  data_flag = as.factor(data_flag))]
```

1JHC
=======================================================================

Row
-------------------------------------

###  Molecule Type {.no-padding}

```{r}
molecule_type <- "1JHC"
valueBox(molecule_type, icon = "fa-globe", color = "rgb(200,100,100)")
```

### Rows in train {.no-padding}

```{r}
train_type <- train[type == molecule_type]
valueBox(nrow(train_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Rows in test {.no-padding}

```{r}
test_type <- test[type == molecule_type]
valueBox(nrow(test_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Mean scalar coupling constant {.no-padding}

```{r}
train_test_type <- train_test[type == molecule_type]
valueBox(round(mean(train_type$scalar_coupling_constant), 2), icon = "fa-chart-bar", color = "rgb(100,100,200)")
```

Row
-------------------------------------

### Scalar Coupling Constant {.no-padding}

```{r}
hchart(train_type$scalar_coupling_constant, name = "Scalar Coupling Constant")
```

### Correlation Matrix
```{r}
hchart(cor(train_type[, -c("id", "molecule_name", "type", "structure_atom_0", "structure_atom_1", "data_flag"), with = F]))
```

Row
-------------------------------------

### Atom Index 0

```{r}
ai_0 <- train_test_type[, .(count = .N), .(atom_index_0, data_flag)]
setorder(ai_0, atom_index_0)
hchart(ai_0, "line", hcaes(x = atom_index_0, y = count, group = data_flag))
```

### Atom Index 1

```{r}
ai_1 <- train_test_type[, .(count = .N), .(atom_index_1, data_flag)]
setorder(ai_1, atom_index_1)
hchart(ai_1, "line", hcaes(x = atom_index_1, y = count, group = data_flag))
```

Row
-------------------------------------

### Structure of x of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_x_0, color = "#d35400", name = "structure_x_0 (train)")
```

### Structure of x of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_x_0, color = "#000000", name = "structure_x_0 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_y_0, color = "#d35400", name = "structure_y_0 (train)")
```

### Structure of y of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_y_0, color = "#000000", name = "structure_y_0 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_z_0, color = "#d35400", name = "structure_z_0 (train)")
```

### Structure of z of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_z_0, color = "#000000", name = "structure_z_0 (test)")
```

Row
-------------------------------------

### Structure of x of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_x_1, color = "#d35400", name = "structure_x_1 (train)")
```

### Structure of x of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_x_1, color = "#000000", name = "structure_x_1 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_y_1, color = "#d35400", name = "structure_y_1 (train)")
```

### Structure of y of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_y_1, color = "#000000", name = "structure_y_1 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_z_1, color = "#d35400", name = "structure_z_1 (train)")
```

### Structure of z of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_z_1, color = "#000000", name = "structure_z_1 (test)")
```

1JHN
=======================================================================

Row
-------------------------------------

###  Molecule Type {.no-padding}

```{r}
molecule_type <- "1JHN"
valueBox(molecule_type, icon = "fa-globe", color = "rgb(200,100,100)")
```

### Rows in train {.no-padding}

```{r}
train_type <- train[type == molecule_type]
valueBox(nrow(train_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Rows in test {.no-padding}

```{r}
test_type <- test[type == molecule_type]
valueBox(nrow(test_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Mean scalar coupling constant {.no-padding}

```{r}
train_test_type <- train_test[type == molecule_type]
valueBox(round(mean(train_type$scalar_coupling_constant), 2), icon = "fa-chart-bar", color = "rgb(100,100,200)")
```

Row
-------------------------------------

### Scalar Coupling Constant {.no-padding}

```{r}
hchart(train_type$scalar_coupling_constant, name = "Scalar Coupling Constant")
```

### Correlation Matrix
```{r}
hchart(cor(train_type[, -c("id", "molecule_name", "type", "structure_atom_0", "structure_atom_1", "data_flag"), with = F]))
```

Row
-------------------------------------

### Atom Index 0

```{r}
ai_0 <- train_test_type[, .(count = .N), .(atom_index_0, data_flag)]
setorder(ai_0, atom_index_0)
hchart(ai_0, "line", hcaes(x = atom_index_0, y = count, group = data_flag))
```

### Atom Index 1

```{r}
ai_1 <- train_test_type[, .(count = .N), .(atom_index_1, data_flag)]
setorder(ai_1, atom_index_1)
hchart(ai_1, "line", hcaes(x = atom_index_1, y = count, group = data_flag))
```

Row
-------------------------------------

### Structure of x of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_x_0, color = "#d35400", name = "structure_x_0 (train)")
```

### Structure of x of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_x_0, color = "#000000", name = "structure_x_0 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_y_0, color = "#d35400", name = "structure_y_0 (train)")
```

### Structure of y of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_y_0, color = "#000000", name = "structure_y_0 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_z_0, color = "#d35400", name = "structure_z_0 (train)")
```

### Structure of z of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_z_0, color = "#000000", name = "structure_z_0 (test)")
```

Row
-------------------------------------

### Structure of x of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_x_1, color = "#d35400", name = "structure_x_1 (train)")
```

### Structure of x of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_x_1, color = "#000000", name = "structure_x_1 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_y_1, color = "#d35400", name = "structure_y_1 (train)")
```

### Structure of y of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_y_1, color = "#000000", name = "structure_y_1 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_z_1, color = "#d35400", name = "structure_z_1 (train)")
```

### Structure of z of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_z_1, color = "#000000", name = "structure_z_1 (test)")
```

2JHC
=======================================================================

Row
-------------------------------------

###  Molecule Type {.no-padding}

```{r}
molecule_type <- "2JHC"
valueBox(molecule_type, icon = "fa-globe", color = "rgb(200,100,100)")
```

### Rows in train {.no-padding}

```{r}
train_type <- train[type == molecule_type]
valueBox(nrow(train_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Rows in test {.no-padding}

```{r}
test_type <- test[type == molecule_type]
valueBox(nrow(test_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Mean scalar coupling constant {.no-padding}

```{r}
train_test_type <- train_test[type == molecule_type]
valueBox(round(mean(train_type$scalar_coupling_constant), 2), icon = "fa-chart-bar", color = "rgb(100,100,200)")
```

Row
-------------------------------------

### Scalar Coupling Constant {.no-padding}

```{r}
hchart(train_type$scalar_coupling_constant, name = "Scalar Coupling Constant")
```

### Correlation Matrix
```{r}
hchart(cor(train_type[, -c("id", "molecule_name", "type", "structure_atom_0", "structure_atom_1", "data_flag"), with = F]))
```

Row
-------------------------------------

### Atom Index 0

```{r}
ai_0 <- train_test_type[, .(count = .N), .(atom_index_0, data_flag)]
setorder(ai_0, atom_index_0)
hchart(ai_0, "line", hcaes(x = atom_index_0, y = count, group = data_flag))
```

### Atom Index 1

```{r}
ai_1 <- train_test_type[, .(count = .N), .(atom_index_1, data_flag)]
setorder(ai_1, atom_index_1)
hchart(ai_1, "line", hcaes(x = atom_index_1, y = count, group = data_flag))
```

Row
-------------------------------------

### Structure of x of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_x_0, color = "#d35400", name = "structure_x_0 (train)")
```

### Structure of x of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_x_0, color = "#000000", name = "structure_x_0 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_y_0, color = "#d35400", name = "structure_y_0 (train)")
```

### Structure of y of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_y_0, color = "#000000", name = "structure_y_0 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_z_0, color = "#d35400", name = "structure_z_0 (train)")
```

### Structure of z of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_z_0, color = "#000000", name = "structure_z_0 (test)")
```

Row
-------------------------------------

### Structure of x of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_x_1, color = "#d35400", name = "structure_x_1 (train)")
```

### Structure of x of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_x_1, color = "#000000", name = "structure_x_1 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_y_1, color = "#d35400", name = "structure_y_1 (train)")
```

### Structure of y of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_y_1, color = "#000000", name = "structure_y_1 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_z_1, color = "#d35400", name = "structure_z_1 (train)")
```

### Structure of z of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_z_1, color = "#000000", name = "structure_z_1 (test)")
```

2JHH
=======================================================================

Row
-------------------------------------

###  Molecule Type {.no-padding}

```{r}
molecule_type <- "2JHH"
valueBox(molecule_type, icon = "fa-globe", color = "rgb(200,100,100)")
```

### Rows in train {.no-padding}

```{r}
train_type <- train[type == molecule_type]
valueBox(nrow(train_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Rows in test {.no-padding}

```{r}
test_type <- test[type == molecule_type]
valueBox(nrow(test_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Mean scalar coupling constant {.no-padding}

```{r}
train_test_type <- train_test[type == molecule_type]
valueBox(round(mean(train_type$scalar_coupling_constant), 2), icon = "fa-chart-bar", color = "rgb(100,100,200)")
```

Row
-------------------------------------

### Scalar Coupling Constant {.no-padding}

```{r}
hchart(train_type$scalar_coupling_constant, name = "Scalar Coupling Constant")
```

### Correlation Matrix
```{r}
hchart(cor(train_type[, -c("id", "molecule_name", "type", "structure_atom_0", "structure_atom_1", "data_flag"), with = F]))
```

Row
-------------------------------------

### Atom Index 0

```{r}
ai_0 <- train_test_type[, .(count = .N), .(atom_index_0, data_flag)]
setorder(ai_0, atom_index_0)
hchart(ai_0, "line", hcaes(x = atom_index_0, y = count, group = data_flag))
```

### Atom Index 1

```{r}
ai_1 <- train_test_type[, .(count = .N), .(atom_index_1, data_flag)]
setorder(ai_1, atom_index_1)
hchart(ai_1, "line", hcaes(x = atom_index_1, y = count, group = data_flag))
```

Row
-------------------------------------

### Structure of x of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_x_0, color = "#d35400", name = "structure_x_0 (train)")
```

### Structure of x of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_x_0, color = "#000000", name = "structure_x_0 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_y_0, color = "#d35400", name = "structure_y_0 (train)")
```

### Structure of y of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_y_0, color = "#000000", name = "structure_y_0 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_z_0, color = "#d35400", name = "structure_z_0 (train)")
```

### Structure of z of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_z_0, color = "#000000", name = "structure_z_0 (test)")
```

Row
-------------------------------------

### Structure of x of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_x_1, color = "#d35400", name = "structure_x_1 (train)")
```

### Structure of x of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_x_1, color = "#000000", name = "structure_x_1 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_y_1, color = "#d35400", name = "structure_y_1 (train)")
```

### Structure of y of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_y_1, color = "#000000", name = "structure_y_1 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_z_1, color = "#d35400", name = "structure_z_1 (train)")
```

### Structure of z of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_z_1, color = "#000000", name = "structure_z_1 (test)")
```

2JHN
=======================================================================

Row
-------------------------------------

###  Molecule Type {.no-padding}

```{r}
molecule_type <- "2JHN"
valueBox(molecule_type, icon = "fa-globe", color = "rgb(200,100,100)")
```

### Rows in train {.no-padding}

```{r}
train_type <- train[type == molecule_type]
valueBox(nrow(train_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Rows in test {.no-padding}

```{r}
test_type <- test[type == molecule_type]
valueBox(nrow(test_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Mean scalar coupling constant {.no-padding}

```{r}
train_test_type <- train_test[type == molecule_type]
valueBox(round(mean(train_type$scalar_coupling_constant), 2), icon = "fa-chart-bar", color = "rgb(100,100,200)")
```

Row
-------------------------------------

### Scalar Coupling Constant {.no-padding}

```{r}
hchart(train_type$scalar_coupling_constant, name = "Scalar Coupling Constant")
```

### Correlation Matrix
```{r}
hchart(cor(train_type[, -c("id", "molecule_name", "type", "structure_atom_0", "structure_atom_1", "data_flag"), with = F]))
```

Row
-------------------------------------

### Atom Index 0

```{r}
ai_0 <- train_test_type[, .(count = .N), .(atom_index_0, data_flag)]
setorder(ai_0, atom_index_0)
hchart(ai_0, "line", hcaes(x = atom_index_0, y = count, group = data_flag))
```

### Atom Index 1

```{r}
ai_1 <- train_test_type[, .(count = .N), .(atom_index_1, data_flag)]
setorder(ai_1, atom_index_1)
hchart(ai_1, "line", hcaes(x = atom_index_1, y = count, group = data_flag))
```

Row
-------------------------------------

### Structure of x of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_x_0, color = "#d35400", name = "structure_x_0 (train)")
```

### Structure of x of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_x_0, color = "#000000", name = "structure_x_0 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_y_0, color = "#d35400", name = "structure_y_0 (train)")
```

### Structure of y of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_y_0, color = "#000000", name = "structure_y_0 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_z_0, color = "#d35400", name = "structure_z_0 (train)")
```

### Structure of z of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_z_0, color = "#000000", name = "structure_z_0 (test)")
```

Row
-------------------------------------

### Structure of x of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_x_1, color = "#d35400", name = "structure_x_1 (train)")
```

### Structure of x of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_x_1, color = "#000000", name = "structure_x_1 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_y_1, color = "#d35400", name = "structure_y_1 (train)")
```

### Structure of y of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_y_1, color = "#000000", name = "structure_y_1 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_z_1, color = "#d35400", name = "structure_z_1 (train)")
```

### Structure of z of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_z_1, color = "#000000", name = "structure_z_1 (test)")
```

3JHC
=======================================================================

Row
-------------------------------------

###  Molecule Type {.no-padding}

```{r}
molecule_type <- "3JHC"
valueBox(molecule_type, icon = "fa-globe", color = "rgb(200,100,100)")
```

### Rows in train {.no-padding}

```{r}
train_type <- train[type == molecule_type]
valueBox(nrow(train_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Rows in test {.no-padding}

```{r}
test_type <- test[type == molecule_type]
valueBox(nrow(test_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Mean scalar coupling constant {.no-padding}

```{r}
train_test_type <- train_test[type == molecule_type]
valueBox(round(mean(train_type$scalar_coupling_constant), 2), icon = "fa-chart-bar", color = "rgb(100,100,200)")
```

Row
-------------------------------------

### Scalar Coupling Constant {.no-padding}

```{r}
hchart(train_type$scalar_coupling_constant, name = "Scalar Coupling Constant")
```

### Correlation Matrix
```{r}
hchart(cor(train_type[, -c("id", "molecule_name", "type", "structure_atom_0", "structure_atom_1", "data_flag"), with = F]))
```

Row
-------------------------------------

### Atom Index 0

```{r}
ai_0 <- train_test_type[, .(count = .N), .(atom_index_0, data_flag)]
setorder(ai_0, atom_index_0)
hchart(ai_0, "line", hcaes(x = atom_index_0, y = count, group = data_flag))
```

### Atom Index 1

```{r}
ai_1 <- train_test_type[, .(count = .N), .(atom_index_1, data_flag)]
setorder(ai_1, atom_index_1)
hchart(ai_1, "line", hcaes(x = atom_index_1, y = count, group = data_flag))
```

Row
-------------------------------------

### Structure of x of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_x_0, color = "#d35400", name = "structure_x_0 (train)")
```

### Structure of x of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_x_0, color = "#000000", name = "structure_x_0 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_y_0, color = "#d35400", name = "structure_y_0 (train)")
```

### Structure of y of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_y_0, color = "#000000", name = "structure_y_0 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_z_0, color = "#d35400", name = "structure_z_0 (train)")
```

### Structure of z of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_z_0, color = "#000000", name = "structure_z_0 (test)")
```

Row
-------------------------------------

### Structure of x of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_x_1, color = "#d35400", name = "structure_x_1 (train)")
```

### Structure of x of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_x_1, color = "#000000", name = "structure_x_1 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_y_1, color = "#d35400", name = "structure_y_1 (train)")
```

### Structure of y of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_y_1, color = "#000000", name = "structure_y_1 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_z_1, color = "#d35400", name = "structure_z_1 (train)")
```

### Structure of z of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_z_1, color = "#000000", name = "structure_z_1 (test)")
```

3JHH
=======================================================================

Row
-------------------------------------

###  Molecule Type {.no-padding}

```{r}
molecule_type <- "3JHH"
valueBox(molecule_type, icon = "fa-globe", color = "rgb(200,100,100)")
```

### Rows in train {.no-padding}

```{r}
train_type <- train[type == molecule_type]
valueBox(nrow(train_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Rows in test {.no-padding}

```{r}
test_type <- test[type == molecule_type]
valueBox(nrow(test_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Mean scalar coupling constant {.no-padding}

```{r}
train_test_type <- train_test[type == molecule_type]
valueBox(round(mean(train_type$scalar_coupling_constant), 2), icon = "fa-chart-bar", color = "rgb(100,100,200)")
```

Row
-------------------------------------

### Scalar Coupling Constant {.no-padding}

```{r}
hchart(train_type$scalar_coupling_constant, name = "Scalar Coupling Constant")
```

### Correlation Matrix
```{r}
hchart(cor(train_type[, -c("id", "molecule_name", "type", "structure_atom_0", "structure_atom_1", "data_flag"), with = F]))
```

Row
-------------------------------------

### Atom Index 0

```{r}
ai_0 <- train_test_type[, .(count = .N), .(atom_index_0, data_flag)]
setorder(ai_0, atom_index_0)
hchart(ai_0, "line", hcaes(x = atom_index_0, y = count, group = data_flag))
```

### Atom Index 1

```{r}
ai_1 <- train_test_type[, .(count = .N), .(atom_index_1, data_flag)]
setorder(ai_1, atom_index_1)
hchart(ai_1, "line", hcaes(x = atom_index_1, y = count, group = data_flag))
```

Row
-------------------------------------

### Structure of x of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_x_0, color = "#d35400", name = "structure_x_0 (train)")
```

### Structure of x of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_x_0, color = "#000000", name = "structure_x_0 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_y_0, color = "#d35400", name = "structure_y_0 (train)")
```

### Structure of y of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_y_0, color = "#000000", name = "structure_y_0 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_z_0, color = "#d35400", name = "structure_z_0 (train)")
```

### Structure of z of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_z_0, color = "#000000", name = "structure_z_0 (test)")
```

Row
-------------------------------------

### Structure of x of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_x_1, color = "#d35400", name = "structure_x_1 (train)")
```

### Structure of x of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_x_1, color = "#000000", name = "structure_x_1 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_y_1, color = "#d35400", name = "structure_y_1 (train)")
```

### Structure of y of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_y_1, color = "#000000", name = "structure_y_1 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_z_1, color = "#d35400", name = "structure_z_1 (train)")
```

### Structure of z of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_z_1, color = "#000000", name = "structure_z_1 (test)")
```

3JHN
=======================================================================

Row
-------------------------------------

###  Molecule Type {.no-padding}

```{r}
molecule_type <- "3JHN"
valueBox(molecule_type, icon = "fa-globe", color = "rgb(200,100,100)")
```

### Rows in train {.no-padding}

```{r}
train_type <- train[type == molecule_type]
valueBox(nrow(train_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Rows in test {.no-padding}

```{r}
test_type <- test[type == molecule_type]
valueBox(nrow(test_type), icon = "fa-table", color = "rgb(100,200,100)")
```

### Mean scalar coupling constant {.no-padding}

```{r}
train_test_type <- train_test[type == molecule_type]
valueBox(round(mean(train_type$scalar_coupling_constant), 2), icon = "fa-chart-bar", color = "rgb(100,100,200)")
```

Row
-------------------------------------

### Scalar Coupling Constant {.no-padding}

```{r}
hchart(train_type$scalar_coupling_constant, name = "Scalar Coupling Constant")
```

### Correlation Matrix
```{r}
hchart(cor(train_type[, -c("id", "molecule_name", "type", "structure_atom_0", "structure_atom_1", "data_flag"), with = F]))
```

Row
-------------------------------------

### Atom Index 0

```{r}
ai_0 <- train_test_type[, .(count = .N), .(atom_index_0, data_flag)]
setorder(ai_0, atom_index_0)
hchart(ai_0, "line", hcaes(x = atom_index_0, y = count, group = data_flag))
```

### Atom Index 1

```{r}
ai_1 <- train_test_type[, .(count = .N), .(atom_index_1, data_flag)]
setorder(ai_1, atom_index_1)
hchart(ai_1, "line", hcaes(x = atom_index_1, y = count, group = data_flag))
```

Row
-------------------------------------

### Structure of x of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_x_0, color = "#d35400", name = "structure_x_0 (train)")
```

### Structure of x of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_x_0, color = "#000000", name = "structure_x_0 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_y_0, color = "#d35400", name = "structure_y_0 (train)")
```

### Structure of y of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_y_0, color = "#000000", name = "structure_y_0 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 0 in train {.no-padding}

```{r}
hchart(train_type$structure_z_0, color = "#d35400", name = "structure_z_0 (train)")
```

### Structure of z of atom index 0 in test {.no-padding}

```{r}
hchart(test_type$structure_z_0, color = "#000000", name = "structure_z_0 (test)")
```

Row
-------------------------------------

### Structure of x of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_x_1, color = "#d35400", name = "structure_x_1 (train)")
```

### Structure of x of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_x_1, color = "#000000", name = "structure_x_1 (test)")
```

Row
-------------------------------------

### Structure of y of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_y_1, color = "#d35400", name = "structure_y_1 (train)")
```

### Structure of y of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_y_1, color = "#000000", name = "structure_y_1 (test)")
```

Row
-------------------------------------

### Structure of z of atom index 1 in train {.no-padding}

```{r}
hchart(train_type$structure_z_1, color = "#d35400", name = "structure_z_1 (train)")
```

### Structure of z of atom index 1 in test {.no-padding}

```{r}
hchart(test_type$structure_z_1, color = "#000000", name = "structure_z_1 (test)")
```

About {data-icon="fa-info-circle"}
=======================================================================

Column
-------------------------------------
