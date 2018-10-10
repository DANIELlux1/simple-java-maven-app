#!/usr/bin/env bash

#'The following Maven command installs your Maven-built Java application'
# 'into the local Maven repository, which will ultimately be stored in'
# 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'
# 'volume).'
set -x
mvn jar:jar install:install help:evaluate -Dexpression=project.name
set +x

# 'The following complex command extracts the value of the <name/> element'
# 'within <project/> of your Java/Maven project''s "pom.xml" file.'
set -x
NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
set +x

# 'The following complex command behaves similarly to the previous one but'
# echo 'extracts the value of the <version/> element within <project/> instead.'
set -x
VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`
set +x

# 'The following command runs and outputs the execution of your Java'
# 'application (which Jenkins built using Maven) to the Jenkins UI.'
set -x
java -jar target/${NAME}-${VERSION}.jar
