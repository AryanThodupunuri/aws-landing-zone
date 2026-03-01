package test

import (
  "testing"
  "github.com/gruntwork-io/terratest/modules/terraform"
)

func TestLandingZonePlan(t *testing.T) {
  t.Parallel()

  opts := &terraform.Options{
    TerraformDir: "../examples/minimal",
    NoColor:      true,
  }

  // run terraform init & plan - output only; don't apply
  terraform.InitAndPlan(t, opts)
}