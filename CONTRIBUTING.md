# Contributing to AWS Landing Zone

We welcome contributions to the AWS Landing Zone project! This document provides guidelines for contributing.

## Getting Started

1. Fork the repository
2. Clone your fork locally
3. Create a new branch for your feature or bug fix
4. Make your changes
5. Test your changes
6. Submit a pull request

## Development Guidelines

### Code Style

- Follow Terraform best practices
- Use consistent naming conventions
- Add comments for complex logic
- Run `terraform fmt` before committing

### Module Structure

Each module should have:
- `main.tf` - Resource definitions
- `variables.tf` - Input variables
- `outputs.tf` - Output values
- `README.md` - Module documentation (if applicable)

### Testing

Before submitting a pull request:

1. Validate your Terraform code:
   ```bash
   terraform fmt -recursive
   terraform init -backend=false
   terraform validate
   ```

2. Test with a real AWS account (if possible):
   ```bash
   terraform plan
   ```

3. Document any breaking changes

### Commit Messages

- Use clear, descriptive commit messages
- Start with a verb (Add, Update, Fix, Remove)
- Reference issues when applicable

Example:
```
Add support for custom KMS keys in S3 module

Closes #123
```

## Pull Request Process

1. Update the README.md with details of changes if applicable
2. Update the version numbers following [Semantic Versioning](https://semver.org/)
3. Ensure all tests pass
4. Request review from maintainers

## Security

If you discover a security vulnerability, please follow our [Security Policy](SECURITY.md).

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Questions?

Feel free to open an issue for any questions or concerns.
