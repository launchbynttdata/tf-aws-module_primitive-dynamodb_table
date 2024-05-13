// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "dynamodb_table" {
  # source  = "d2lqlh14iel5k2.cloudfront.net/module_primitive/api_gateway_v2/aws"
  # version = "~> 1.0"
  source = "../.."

  name     = module.resource_names["dynamodb_table"].minimal_random_suffix
  hash_key = "my_key"

  attributes = {
    "my_key" = "S"
  }

  ttl_enabled        = true
  ttl_attribute_name = "foo_date"
}

module "resource_names" {
  source  = "d2lqlh14iel5k2.cloudfront.net/module_library/resource_name/launch"
  version = "~> 1.0"

  for_each = var.resource_names_map

  region                  = join("", split("-", each.value.region))
  class_env               = var.class_env
  cloud_resource_type     = each.value.name
  instance_env            = var.instance_env
  instance_resource       = var.instance_resource
  maximum_length          = each.value.max_length
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
}