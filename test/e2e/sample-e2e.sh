#!/usr/bin/env bash

# Copyright 2019 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

source "$(dirname "$0")/../common.sh"
source "$(dirname "$0")/setup.sh"

build_sample_external_plugin

export KIND_CLUSTER="kind"
create_cluster ${KIND_K8S_VERSION}
trap delete_cluster EXIT

KUSTOMIZATION_FILE_PATH="$(dirname "$0")/../../testdata/project-v4/config/default/kustomization.yaml"

sed -i '25s/^#//' $KUSTOMIZATION_FILE_PATH
sed -i '27s/^#//' $KUSTOMIZATION_FILE_PATH
sed -i '42s/^#//' $KUSTOMIZATION_FILE_PATH
sed -i '46,143s/^#//' $KUSTOMIZATION_FILE_PATH

cd $(dirname "$0")/../../testdata/project-v4
go get -u ./...
make test-e2e