##  v1.2.0

- Content update for the 2021 annual review

## v1.1.0

**Chore:**
  - Widespread updates to written content and statistics
    - `lib/data/content/home/stats-finance.yml`
    - `lib/data/content/home/stats-people.yml`
    - `lib/data/content/home/projects.yml`
    - `lib/data/content/home/projects-links.yml`
    - `lib/data/content/home/impacts.yml`
    - `lib/data/content/home/highlights.yml`
    - `lib/data/content/home/highlights-links.yml`
    - `lib/data/content/home/hero.yml`
    - `lib/data/content/home/future.yml`
    - `lib/data/content/home/forewords.yml`
    - `lib/data/content/home/foreword.yml`
    - `lib/data/content/home/anniversary.yml` (Removed)
    - Content-related helper methods in `app/helpers/application_helper.rb`
  - Widespread updates to visual content
    - Delete unused images
    - Add new images
    - Update YouTube video href attribute @ `app/views/home/partials/_foreword.html.erb`
    - Methods in `app/helpers/application_helper.rb`
  - Widespread tweaks in code formatting
  - Tweak previous entries in CHANGELOG.md to have

**Style:**
  - Widespread styling changes:
    - `app/assets/stylesheets/base/_variables.scss`
      - New variables for breakpoints, gutters, colours
      - Establish `fw-` namespacing for font weights
    - `app/assets/stylesheets/components/_modal.scss`
    - `app/assets/stylesheets/components/_carousel.scss` ( Add styles for impacts carousel )
  - New stylesheets
    - `app/assets/stylesheets/components/_forewords.scss`
    - `app/assets/stylesheets/components/_foreword.scss`

**Feat:**
  - New sections:
    - `app/views/home/partials/_forewords.html.erb`
  - New components:
    - `app/javascript/components/forewords/Foreword.vue`

**Fix:**
  - Add hotjar tracking code in `app/views/layouts/global/_head.html.erb`
  - Adjust styling and markdown:
    - `app/views/home/partials/_stats-people.html.erb`
    - `app/views/home/partials/_projects.html.erb`


##  v1.0.3

**Styling fixes**

- Small styling fixes.

##  v1.0.2

**Text fixes**

- Small text fixes.

##  v1.0.1

**Theme icons**

- Update theme icons.

##  v1.0.0

**Initial build of the website**

- Initial build of the website ready for soft launch.
