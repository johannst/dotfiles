# dotfiles

Installer framework only availabl in bash.

### Control installation 
Installation of the config files is controlled with the `install.config` file. The format of a line in the file is as follows:
```
[yYnN] - <config_tag>
```
Where `yY` means to install the config file and `nN` means to skip installation for this config file.
Any line not matching the regex `^[yYnN][[:blank:]]?-` is ignored. 


The installation process is triggered by executing the `install` file.

### Adapt installation of config files
The installation of a particular config file can be adapted by modifying the corresponding installer function.
Follow the `<config_tag>` in the `gToolsConfig` map (defined in `install`) to find the name of the installer function. The name is the third entry for the tag.

### Adding additional config files

First add an entry in the `gToolsConfig` map in the `install` file. Entries have the following format:
```
"<config_tag>:<dep_binary>:<installer_function_name>"
```
Then create and implement the installer function with the name provided in the newly created entry.

Then create an entry in the `install.config` file with the tag that matches the tag provided in the `gToolsConfig`.
