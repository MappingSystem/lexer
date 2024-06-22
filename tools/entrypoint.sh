#!/usr/bin/env bash

#gcloud auth/credential_file_override activate-service-account project-owner@feedmapping.iam.gserviceaccount.com
gcloud config set account project-owner@feedmapping.iam.gserviceaccount.com
gcloud info
