use inc::Module::Install;
name 'Acme-Sacana';
all_from 'lib/Acme/Sacana.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
