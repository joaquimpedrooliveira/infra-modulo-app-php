package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestApachePhpInfraAws(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/sample-app",
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	publicDNS := terraform.Output(t, terraformOptions, "public_dns")
	url := fmt.Sprintf("http://%s/%s", publicDNS, "info.php")
	http_helper.HttpGetWithRetry(t, url, nil, 200, "Versão atual do PHP: 7.2.24-0ubuntu0.18.04.6", 10, 10*time.Second)
}
