# Helm Chart for Plausible Analytics
 
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) ![version](https://img.shields.io/github/tag/IMIO/helm-plausible-analytics.svg?label=release) ![test](https://github.com/IMIO/helm-plausible-analytics/actions/workflows/test.yaml/badge.svg) ![release](https://github.com/IMIO/helm-plausible-analytics/actions/workflows/release.yaml/badge.svg) [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/imio)](https://artifacthub.io/packages/search?repo=imio)

## Introduction

This [Helm](https://helm.sh/) chart installs `Plausible Analytics` in a [Kubernetes](https://kubernetes.io/) cluster. 

## Prerequisites

> [!NOTE]
> For production environments, it is recommended to use [CloudNativePG](https://github.com/cloudnative-pg/cloudnative-pg) for PostgreSQL and the [ClickHouse Operator](https://github.com/Altinity/clickhouse-operator) for ClickHouse instead of the dependent Helm charts included here. The bundled charts are primarily intended for testing and development purposes.

- Kubernetes cluster 1.12+
- Helm 3.0.0+
- PV provisioner support in the underlying infrastructure (Optional)
- Postgres DB (Optional, installed by this helm chart)
- ClickHouse (Optional, installed by this helm chart)

## Installation

### Add Helm repository

```bash
helm repo add imio https://imio.github.io/helm-charts
helm repo update
```

### Configure the chart

The following items can be set via `--set` flag during installation or configured by editing the `values.yaml` directly (need to download the chart first).

Feel free to modify the options in the [values.yaml file](values.yaml) before installation.

You will need to set the sensitive values in the values.yaml file before installing the chart. (Passwords and URL of the databases).

### Install the chart

```bash
helm install [RELEASE_NAME] imio/plausible-analytics
```

or by cloning this repository:

```bash
git clone https://github.com/imio/helm-plausible-analytics.git
cd helm-plausible-analytics
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm dep up
helm install plausible-analytics . -f values.yaml --namespace plausible-analytics --create-namespace
```

## Configuration

The following table lists the configurable parameters of the plausible-analytics chart and the default values.

See the [values.yaml](values.yaml) file for more information.

## Credits

Initially inspired by 
* [https://github.com/8gears/plausible-analytics-helm-chart](https://github.com/8gears/plausible-analytics-helm-chart).
* [Plausible Analytics Repository](https://github.com/plausible/analytics).

## Contributing

Feel free to contribute by making a [pull request](https://github.com/imio/helm-plausible-analytics/pull/new/master).

Please read the official [Helm Contribution Guide](https://github.com/helm/charts/blob/master/CONTRIBUTING.md) from Helm for more information on how you can contribute to this Chart.

## License

[Apache License 2.0](/LICENSE)
