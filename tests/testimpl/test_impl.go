package testimpl

import (
	"context"
	"testing"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestComposableComplete(t *testing.T, ctx types.TestContext) {
	awsClient := GetAWSDynamoDBClient(t)

	t.Run("TestTableExists", func(t *testing.T) {
		awsDynamoDBTableArn := terraform.Output(t, ctx.TerratestTerraformOptions(), "dynamodb_table_arn")
		awsDynamoDBTableName := terraform.Output(t, ctx.TerratestTerraformOptions(), "dynamodb_table_id")

		table, err := awsClient.DescribeTable(context.TODO(), &dynamodb.DescribeTableInput{
			TableName: &awsDynamoDBTableName,
		})
		if err != nil {
			t.Errorf("Failure during DescribeTable: %v", err)
		}

		assert.Equal(t, *table.Table.TableArn, awsDynamoDBTableArn, "Expected ARN did not match actual ARN!")
		assert.Equal(t, *table.Table.TableName, awsDynamoDBTableName, "Expected ARN did not match actual ARN!")
	})
}

func GetAWSDynamoDBClient(t *testing.T) *dynamodb.Client {
	awsDynamoDBClient := dynamodb.NewFromConfig(GetAWSConfig(t))
	return awsDynamoDBClient
}

func GetAWSConfig(t *testing.T) (cfg aws.Config) {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	require.NoErrorf(t, err, "unable to load SDK config, %v", err)
	return cfg
}
