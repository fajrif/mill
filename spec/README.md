# Mill Aluminium - RSpec Test Suite

This directory contains comprehensive RSpec tests for the Mill Aluminium application, covering models, controllers, routing, and authentication for both public and admin interfaces.

## Test Coverage

### Models (`spec/models/`)
- **Admin** - Authentication, validations, Devise modules
- **Article** - Validations, associations, FriendlyId slugs
- **Event** - Validations, associations, FriendlyId slugs
- **Product** - Validations, associations, FriendlyId slugs, class methods
- **Project** - Validations, associations, FriendlyId slugs, class methods
- **Feature** - Validations, associations
- **Category** - Validations
- **Contact** - Validations

### Routing (`spec/routing/`)
- **Public Routes** - Home, About, Products, Projects, Articles, Events, Contact
- **Admin Routes** - Devise authentication, Dashboard, All resource CRUD routes

### Admin Request Specs (`spec/requests/admins/`)
- **Authentication** - Sign in/out, authentication requirements, session management
- **Articles CRUD** - Full CRUD operations with validation testing
- **Events CRUD** - Full CRUD operations with validation testing
- **Products CRUD** - Full CRUD operations with FriendlyId testing
- **Projects CRUD** - Full CRUD operations with client_name testing
- **Features CRUD** - Full CRUD operations

### Public Request Specs (`spec/requests/public/`)
- **Home** - Index and About pages
- **Products** - Index and show pages with pagination
- **Projects** - Index and show pages with pagination
- **Articles** - Index and show pages with pagination
- **Events** - Index and show pages with pagination
- **Contacts** - Contact form submission and validation

## Running Tests

### Run all tests
```bash
bundle exec rspec
```

### Run specific test files
```bash
# Run model tests
bundle exec rspec spec/models

# Run admin request tests
bundle exec rspec spec/requests/admins

# Run public request tests
bundle exec rspec spec/requests/public

# Run routing tests
bundle exec rspec spec/routing

# Run a specific file
bundle exec rspec spec/models/product_spec.rb

# Run a specific test
bundle exec rspec spec/models/product_spec.rb:25
```

### Run tests with documentation format
```bash
bundle exec rspec --format documentation
```

### Run tests with coverage report
```bash
COVERAGE=true bundle exec rspec
```

## Test Database Setup

Before running tests, ensure your test database is set up:

```bash
# Create test database
RAILS_ENV=test rails db:create

# Run migrations
RAILS_ENV=test rails db:migrate

# Reset test database if needed
RAILS_ENV=test rails db:reset
```

## Factories

Test factories are located in `spec/factories/` and use FactoryBot to create test data:

```ruby
# Create a product
product = create(:product)

# Build a product without saving
product = build(:product)

# Create with specific attributes
product = create(:product, name: 'Custom Product')

# Create multiple records
products = create_list(:product, 3)
```

## Test Helpers

### Authentication Helper
```ruby
# Sign in as admin in request specs
let(:admin) { create(:admin) }
before { sign_in admin }

# Sign out
before { sign_out admin }
```

### Factory Examples
```ruby
# Create an admin
admin = create(:admin)

# Create a product with images
product = create(:product) # Automatically attaches image and banner

# Create an article with category
article = create(:article) # Automatically creates category and attaches image

# Create a project with client
project = create(:project, client_name: 'Custom Client')
```

## Test Data Files

Test fixture files are located in `spec/fixtures/files/`:
- `test_image.jpg` - Used for image attachments
- `test_banner.jpg` - Used for banner attachments

## What's Being Tested

### Authentication
- ✅ Admin sign in/out functionality
- ✅ Valid/invalid credentials
- ✅ Protected route access
- ✅ Session management

### CRUD Operations
- ✅ Index - List all records
- ✅ Show - Display single record
- ✅ New - Display form for new record
- ✅ Create - Save new record with validations
- ✅ Edit - Display form for existing record
- ✅ Update - Save changes with validations
- ✅ Destroy - Delete records

### Validations
- ✅ Presence validations
- ✅ Uniqueness validations
- ✅ Email format validations
- ✅ Attachment validations

### Associations
- ✅ belongs_to relationships
- ✅ has_one_attached (Active Storage)
- ✅ has_many_attached (Active Storage)

### FriendlyId Slugs
- ✅ Slug generation from name/title
- ✅ Finding records by slug
- ✅ Slug regeneration on update

### Pagination
- ✅ Kaminari pagination testing
- ✅ Page navigation

## Test Statistics

Total Specs: ~250+

Coverage Areas:
- Models: 8 model specs
- Routing: 2 routing specs (public + admin)
- Admin Requests: 6 request specs
- Public Requests: 6 request specs

## Continuous Integration

To run tests in CI/CD pipelines:

```yaml
# Example GitHub Actions
test:
  runs-on: ubuntu-latest
  services:
    postgres:
      image: postgres:14
  steps:
    - uses: actions/checkout@v2
    - name: Setup Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: 3.3.0
        bundler-cache: true
    - name: Setup Database
      run: |
        RAILS_ENV=test bundle exec rails db:create
        RAILS_ENV=test bundle exec rails db:migrate
    - name: Run Tests
      run: bundle exec rspec
```

## Troubleshooting

### Common Issues

1. **Database errors**
   ```bash
   RAILS_ENV=test rails db:reset
   ```

2. **Missing test images**
   ```bash
   mkdir -p spec/fixtures/files
   # Images should be automatically created during setup
   ```

3. **Factory errors**
   ```bash
   # Ensure factories are properly defined
   bundle exec rails factory_bot:lint
   ```

4. **Authentication errors**
   ```bash
   # Make sure Devise is properly configured
   # Check that admin factory has valid password
   ```

## Best Practices

1. **Keep tests isolated** - Each test should be independent
2. **Use factories** - Don't create records manually
3. **Test edge cases** - Invalid data, missing data, etc.
4. **Keep tests fast** - Use `build` instead of `create` when possible
5. **Clear test names** - Describe what is being tested
6. **DRY principle** - Use shared examples and contexts

## Adding New Tests

When adding new features:

1. Create factory in `spec/factories/`
2. Add model spec in `spec/models/`
3. Add routing spec in `spec/routing/`
4. Add request spec in `spec/requests/`
5. Run tests to ensure they pass

Example:
```ruby
# spec/models/new_model_spec.rb
require 'rails_helper'

RSpec.describe NewModel, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:new_model)).to be_valid
    end
  end
end
```

## Resources

- [RSpec Rails Documentation](https://rspec.info/features/6-0/rspec-rails/)
- [FactoryBot Documentation](https://github.com/thoughtbot/factory_bot)
- [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers)
- [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner)
