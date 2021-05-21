package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(handler)
}

// HandleRequest is the Lambda handler to process requests
func handler(ctx context.Context, event events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	fmt.Println("Hello, world!")
	fmt.Println(event)
	return events.APIGatewayProxyResponse{
		Body:       "Hello, world",
		StatusCode: 200,
	}, nil
}
