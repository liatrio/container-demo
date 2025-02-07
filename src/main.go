package main

import (
	"github.com/gin-gonic/gin"

	_ "github.com/aws/aws-sdk-go/aws"
	_ "github.com/aws/aws-sdk-go/service/s3"
	_ "github.com/go-redis/redis"
	_ "github.com/google/go-cmp/cmp"
	_ "github.com/opentracing/opentracing-go"
	_ "google.golang.org/grpc"
	_ "google.golang.org/grpc/credentials"
)

func main() {
	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		c.String(200, "hello Liatrio")
	})
	r.Run(":8080")
}
