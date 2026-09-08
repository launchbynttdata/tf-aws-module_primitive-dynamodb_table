# tf-aws-module_primitive-dynamodb_table

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This Terraform module creates an AWS DynamoDB table.

## Usage

See [examples/minimal](examples/minimal) for a deployable example.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.14 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Attributes of fields on the table. | `map(string)` | n/a | yes |
| <a name="input_billing_mode"></a> [billing\_mode](#input\_billing\_mode) | Controls how you are charged for read and write throughput and how you manage capacity. The valid values are `PROVISIONED` and `PAY_PER_REQUEST`. Defaults to `PAY_PER_REQUEST`. | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_deletion_protection_enabled"></a> [deletion\_protection\_enabled](#input\_deletion\_protection\_enabled) | Enables deletion protection for table. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_hash_key"></a> [hash\_key](#input\_hash\_key) | Attribute to use as the hash (partition) key. Changes to this value forces creation of a new resourece. This must be defined in `attributes`. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Unique within a region name of the table. | `string` | n/a | yes |
| <a name="input_point_in_time_recovery"></a> [point\_in\_time\_recovery](#input\_point\_in\_time\_recovery) | Whether to enable point-in-time recovery. This can take up to 10 minutes to enable for new tables. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_range_key"></a> [range\_key](#input\_range\_key) | Attribute to use as the range (sort) key. Changes to this value forces creation of a new resourece. This must be defined in `attributes`. | `string` | `null` | no |
| <a name="input_read_capacity"></a> [read\_capacity](#input\_read\_capacity) | Number of read units for this table. If the `billing_mode` is `PROVISIONED`, this field is required. For details on read units, see: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/provisioned-capacity-mode.html#read-write-capacity-units | `number` | `null` | no |
| <a name="input_table_class"></a> [table\_class](#input\_table\_class) | Storage class of the table. Valid values are `STANDARD` and `STANDARD_INFREQUENT_ACCESS`. Default value is `STANDARD`. | `string` | `"STANDARD"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to the API. | `map(string)` | `null` | no |
| <a name="input_ttl_attribute_name"></a> [ttl\_attribute\_name](#input\_ttl\_attribute\_name) | Name of the table attribute to store the TTL timestamp in. Has no effect unless `ttl_enabled` is set to `true`. | `string` | `null` | no |
| <a name="input_ttl_enabled"></a> [ttl\_enabled](#input\_ttl\_enabled) | Whether TTL is eanbled. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_write_capacity"></a> [write\_capacity](#input\_write\_capacity) | Number of write units for this table. If the `billing_mode` is `PROVISIONED`, this field is required. For details on write units, see: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/provisioned-capacity-mode.html#read-write-capacity-units | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the table |
| <a name="output_id"></a> [id](#output\_id) | Name of the table |
<!-- END_TF_DOCS -->

## Module Development

### Pre-Requisites

The following commands should be available on your system:

- `asdf` or `mise`
- `make`
- `python3` (for pre-commit)

Additionally, your `git` user and email must be configured. Run the `make configure` command from the root of the repository to ensure that you meet these requirements.

### Pre-Commit hooks

The [.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to Terraform and Golang, as well as some common linting tasks. These will be configured for you when you run `make configure`.

### Local Validation

You should validate the changes you make to any module locally, prior to pushing your changes in a branch to GitHub.

1. Ensure that you have run `make configure` successfully.

2. Ensure you are signed into the appropriate cloud provider (e.g. AWS or Azure) for the module under test in your current console session.

3. Run the Terraform and Golang linters with the following command:

```
make lint
```

4. Once you have satisfied the linters, the following command will build example infrastructure in your configured cloud, run the tests, and then tear down the infrastructure it created:

```
make test
```

The pre-commit validations, as well as the `make lint` and `make test` targets, will all be performed in CI. Running these validations locally prior to opening a PR helps ensure a smooth review and merge process.

### Review & Merge Process

Once your change has been tested locally and your branch pushed up, open a new Pull Request for your branch to the default (main) branch of this repository.

The title of your Pull Request will determine the version bump for this change, and the title must be in [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#specification) format in order to merge. A breaking change will trigger a major version bump, a feature will trigger a minor version bump, and all other types will trigger a patch version bump.

Ensure your CI workflows are passing; seek approval from teammates and address any feedback; seek any explicit approvals required by the CODEOWNERS file. You may merge the PR as soon as all requirements are met, and a new release and tag will be automatically created for you.

### Automatic Updates

The shared configuration and workflow files in this repository are largely managed through the [launch-terraform-skeleton](https://github.com/launchbynttdata/launch-terraform-skeleton) repository. Outside of perhaps the `.gitignore` to account for specific files being generated by certain Terraform modules (e.g. Lambda functions), there should not be much cause to update these files on a per-repo basis, and making changes to them individually is discouraged.

If desired, you can check for and run these updates locally in a branch if you have the `copier` tool installed. Some example commands are included below:

```
# Check for updates, optionally checking prerelease versions
copier check-update [--prereleases]

# Run an update, using default answers if there are any. We use tasks, which requires --trust to be set.
copier update --defaults --trust [--prereleases]

# Recopy from the source, and --overwrite all templated files in the process
copier recopy --defaults --trust --overwrite [--prereleases]
```

Automatic updates will run through a scheduled workflow, and if the post-update tests are successful, the Pull Request created will automatically merge. Conflicts in the update or failures to test may leave a Pull Request outstanding, which needs to be addressed by a Launch Engineer.
