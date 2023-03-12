# Problems faced in the entire process.

* Terraform 0.11.11 cannot contain interpolations in backend configurations. The limitation on using interpolations in backend configurations was fixed in Terraform 0.12.0.
* Tried to upgrade the existing scripts to 0.14 by incrementally moving from 0.12 to 0.13 to 0.14 and faced few issues like syntax changes were not completely migrated to higer versions and they required the syntax changed manually in main.tf like tags and map object changes were not taken. Due to interest of time kept it as is.
* terraform backend cannot have s3 and dynamodb locks in 0.11.x version so ignoring it for now.
* Avoided using workspace as a folder structure is easier to maintain and no major issues arise in using them.
