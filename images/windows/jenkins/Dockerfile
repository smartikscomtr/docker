ARG WINDOWS_VERSION

FROM smartikscomtr/chocolatey:latest-windowsservercore-${WINDOWS_VERSION}

LABEL maintainer="murat.atay@smartiks.com.tr"

ARG JENKINS_VERSION

ENV JENKINS_VERSION ${JENKINS_VERSION}

ENV JENKINS_HOME C:\\bin\\jenkins

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue';"]

RUN choco install jdk8

RUN choco install git

RUN choco install nodejs-lts

RUN choco install yarn

RUN choco install dotnetcore-sdk

RUN choco install netfx-4.6.1-devpack

RUN choco install netfx-4.6.2-devpack

RUN choco install netfx-4.7-devpack

RUN choco install netfx-4.7.1-devpack

RUN choco install netfx-4.7.2-devpack

RUN choco install visualstudio2017buildtools

RUN choco install visualstudio2017-workload-webbuildtools

RUN choco install docker

RUN New-Item -Type Directory -Path /bin/jenkins; \
    Invoke-WebRequest -Uri "http://ftp-nyc.osuosl.org/pub/jenkins/war-stable/${env:JENKINS_VERSION}/jenkins.war" -OutFile /bin/jenkins.war -UseBasicParsing

COPY rootfs/ /

ENTRYPOINT []

CMD /bin/jenkins.ps1