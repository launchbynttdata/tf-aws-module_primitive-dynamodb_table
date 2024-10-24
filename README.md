# tf-aws-module_primitive-api_gateway_v2_stage

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

Provides a DynamoDB Table.

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.14 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.73.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Unique within a region name of the table. | `string` | n/a | yes |
| <a name="input_hash_key"></a> [hash\_key](#input\_hash\_key) | Attribute to use as the hash (partition) key. Changes to this value forces creation of a new resourece. This must be defined in `attributes`. | `string` | n/a | yes |
| <a name="input_range_key"></a> [range\_key](#input\_range\_key) | Attribute to use as the range (sort) key. Changes to this value forces creation of a new resourece. This must be defined in `attributes`. | `string` | `null` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Attributes of fields on the table. | `map(string)` | n/a | yes |
| <a name="input_billing_mode"></a> [billing\_mode](#input\_billing\_mode) | Controls how you are charged for read and write throughput and how you manage capacity. The valid values are `PROVISIONED` and `PAY_PER_REQUEST`. Defaults to `PAY_PER_REQUEST`. | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_read_capacity"></a> [read\_capacity](#input\_read\_capacity) | Number of read units for this table. If the `billing_mode` is `PROVISIONED`, this field is required. For details on read units, see: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/provisioned-capacity-mode.html#read-write-capacity-units | `number` | `null` | no |
| <a name="input_write_capacity"></a> [write\_capacity](#input\_write\_capacity) | Number of write units for this table. If the `billing_mode` is `PROVISIONED`, this field is required. For details on write units, see: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/provisioned-capacity-mode.html#read-write-capacity-units | `number` | `null` | no |
| <a name="input_table_class"></a> [table\_class](#input\_table\_class) | Storage class of the table. Valid values are `STANDARD` and `STANDARD_INFREQUENT_ACCESS`. Default value is `STANDARD`. | `string` | `"STANDARD"` | no |
| <a name="input_point_in_time_recovery"></a> [point\_in\_time\_recovery](#input\_point\_in\_time\_recovery) | Whether to enable point-in-time recovery. This can take up to 10 minutes to enable for new tables. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_deletion_protection_enabled"></a> [deletion\_protection\_enabled](#input\_deletion\_protection\_enabled) | Enables deletion protection for table. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_ttl_enabled"></a> [ttl\_enabled](#input\_ttl\_enabled) | Whether TTL is eanbled. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_ttl_attribute_name"></a> [ttl\_attribute\_name](#input\_ttl\_attribute\_name) | Name of the table attribute to store the TTL timestamp in. Has no effect unless `ttl_enabled` is set to `true`. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to the API. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the table |
| <a name="output_id"></a> [id](#output\_id) | Name of the table |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
