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


variable "name" {
  description = "Unique within a region name of the table."
  type        = string

  validation {
    condition     = length(var.name) <= 255 && length(var.name) >= 3
    error_message = "Table name must be between 3 and 255 characters in length."
  }

  validation {
    condition     = can(regex("[a-zA-Z0-9\\._-]+", var.name))
    error_message = "Table name must only contain characters a-z, A-Z, 0-9, . (dot), _ (underscore) and - (dash)."
  }
}

variable "hash_key" {
  description = "Attribute to use as the hash (partition) key. Changes to this value forces creation of a new resourece. This must be defined in `attributes`."
  type        = string
}

variable "range_key" {
  description = "Attribute to use as the range (sort) key. Changes to this value forces creation of a new resourece. This must be defined in `attributes`."
  type        = string
  default     = null
}

variable "attributes" {
  description = "Attributes of fields on the table."
  type        = map(string)

  validation {
    condition     = alltrue([for name, type in var.attributes : length(name) <= 255])
    error_message = "Attribute name should be 255 or fewer characters in length."
  }

  validation {
    condition     = alltrue([for name, type in var.attributes : contains(["N", "S", "B"], type)])
    error_message = "Attribute type must be 'N' (number), 'S' (string), or 'B' (bytes)."
  }
}

variable "billing_mode" {
  description = "Controls how you are charged for read and write throughput and how you manage capacity. The valid values are `PROVISIONED` and `PAY_PER_REQUEST`. Defaults to `PAY_PER_REQUEST`."
  type        = string
  default     = "PAY_PER_REQUEST"

  validation {
    condition     = contains(["PROVISIONED", "PAY_PER_REQUEST"], var.billing_mode)
    error_message = "billing_mode must be one of PROVISIONED, PAY_PER_REQUEST."
  }
}

variable "read_capacity" {
  description = "Number of read units for this table. If the `billing_mode` is `PROVISIONED`, this field is required. For details on read units, see: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/provisioned-capacity-mode.html#read-write-capacity-units"
  type        = number
  default     = null
}

variable "write_capacity" {
  description = "Number of write units for this table. If the `billing_mode` is `PROVISIONED`, this field is required. For details on write units, see: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/provisioned-capacity-mode.html#read-write-capacity-units"
  type        = number
  default     = null
}

variable "table_class" {
  description = "Storage class of the table. Valid values are `STANDARD` and `STANDARD_INFREQUENT_ACCESS`. Default value is `STANDARD`."
  type        = string
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "STANDARD_INFREQUENT_ACCESS"], var.table_class)
    error_message = "table_class must be one of STANDARD, STANDARD_INFREQUENT_ACCESS."
  }
}

variable "point_in_time_recovery" {
  description = "Whether to enable point-in-time recovery. This can take up to 10 minutes to enable for new tables. Defaults to `false`."
  type        = bool
  default     = false
}


variable "deletion_protection_enabled" {
  description = "Enables deletion protection for table. Defaults to `false`."
  type        = bool
  default     = false
}

variable "ttl_enabled" {
  description = "Whether TTL is eanbled. Defaults to `false`."
  type        = bool
  default     = false
}

variable "ttl_attribute_name" {
  description = "Name of the table attribute to store the TTL timestamp in. Has no effect unless `ttl_enabled` is set to `true`."
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of tags to assign to the API."
  type        = map(string)
  default     = null
}
