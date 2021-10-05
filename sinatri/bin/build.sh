#!/usr/bin/env bash

set -o errexit


download_gems(){
    mkdir -p ruby/gems && \

    docker run --rm -v $PWD:/var/layer -w /var/layer lambci/lambda:build-ruby2.5 bundle install --path=ruby/gems && \

    mv ruby/gems/ruby/* ruby/gems/ && \
    rm -rf ruby/gems/2.5.0/cache && \
    rm -rf ruby/gems/ruby && \
        zip -r layer.zip ruby ;
}


archive_api_code(){
    zip -r9 api.zip ./api
}


print_help(){
    printf "\
Help: build lambda's pre-deploy packages

usage: build (--layer|--lambda)
"
}


case ${1:?arg-err: opt(--layer|--lambda|-h)} in
    --layer )
            download_gems
        ;;
    --lambda )
            archive_api_code
        ;;
     -h )
            print_help
        ;;
esac
