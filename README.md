# mSpray Monitor

Malaria is a serious problem, but cheap solutions like spraying homes and residential areas with chemicals like DDT can be only slightly better. mSpray attempts to use phone technology to track the usage of DDT to monitor the usage of the chemical and prevent over-spraying of residential areas, while also monitoring alternative chemicals like K-Orthrine and Fendona to see if they are an equally effective solution to malaria without the same lethal consequences. The app can also be used to report current cases of malaria to call government workers to come and address patients' medical needs immediately. All collected data is sent to a database in the cloud, and can be monitored via the mSpray webapp. This app can also use the collected data to plan future sprays and prevent outbreaks of malaria.

## Getting Started

Install updated latest openssl, mariadb, rbenv
```
brew install mariadb openssl rbenv
```

Once all code is checked out, developers need to install Ruby 2.7.1. Here's how to do it with rbenv, if it is available:
```
rbenv install 3.0.1
rbenv global 3.0.1
```

Once ruby is installed, developers need to install PostGresQL, the DB for development environments. If developers are on a mac, they can install PostGresQL by following the instructions at: https://postgresapp.com/, and then running
```
gem install pg -- --with-pg-config=/Applications/Postgres.app/Contents/Versions/latest/bin/pg_config
```

After installing PostGresQL, install Java and the rjb gem by first installing the OLD java at: https://www.oracle.com/java/technologies/javase/jdk16-archive-downloads.html, and running:
```
gem install rjb -v 1.6.2
```

After installing rjb, installing all other gems (dependencies of the app) can be achieved by running:
```
bundle
```

Setting up the database can be done by calling:
```
mysql.server start
make server
```
NOTE: This destructively sets up the database by creating a whole new one and filling it with seed data. Running database updates can be done by simply calling:
```
rake db:migrate
```

## Running Tests

The app is currently in development and doesn't have tests enabled yet, but once they are written, tests can be called by running:
```
rspec
```

## Deployment

The app is currently in development and doesn't have a production environment yet, but once it is available, changes can be pushed live with:
```
git co master
git push heroku HEAD
```

## Acknowledgments

* Brenda Eskenazi (MA, PhD), Lesliam Quirós-Alcalá (MS, PhD), Edmund Seto (MS, PhD) - Leads for the mobile project when it was first started in UC Berkeley in 2012
* Philip Kruger (Department of Health, Limpopo Province, South Africa), Tzundzukani Ntimbane, Riana Bornman (MBChB, DSc, MD), Jonah M. Lipsitt (PhD) - In-field collaborators with the mSpray project
