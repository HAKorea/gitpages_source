module Jekyll
  class EnvironmentVariablesGenerator < Generator
    def generate(site)
      # https://www.netlify.com/docs/continuous-deployment/#build-environment-variables
      repo_url = 'https://github.com/hakorea/gitpages_source'

      # Rewrite urls if repo url is the ssh format.
      if repo_url.start_with? 'git@github.com:'
        repo_url = repo_url.sub 'git@github.com:', 'https://github.com/'
      end

      # These values will be available as {{ site.NLY_REPOSITORY_URL }}
      site.config['NLY_REPOSITORY_URL'] = repo_url
      site.config['NLY_HEAD'] = ENV['HEAD'] || 'master'
    end
  end
end
