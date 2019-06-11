FROM ruby:2.5.5 
MAINTAINER calvarez1@miuandes.cl

RUN apt-get update && apt-get install -y \ 
  build-essential \ 
  nodejs \
  postgresql-client

RUN mkdir -p /app 
WORKDIR /app

COPY Gemfile Gemfile.lock ./ 
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

RUN export DATABASE_HOST=10.138.0.5
RUN export DATABASE_USERNAME=postgres
RUN export DATABASE_PASSWORD=7kq27.3519a

CMD ["RAILS_ENV=production", "bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

