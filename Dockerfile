FROM jruby:9.0.5.0-onbuild
CMD ["cd app"]
CMD ["./app.rb"]