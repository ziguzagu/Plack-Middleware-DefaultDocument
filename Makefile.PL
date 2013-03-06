use inc::Module::Install;

name 'Plack-Middleware-DefaultDocument';
all_from 'lib/Plack/Middleware/DefaultDocument.pm';
readme_from 'lib/Plack/Middleware/DefaultDocument.pm';
authority 'ZIGUZAGU';

requires 'Plack';

test_requires 'Test::More', 0.96;

tests 't/*.t';
author_tests 'xt';

auto_include;
auto_set_repository;

WriteAll;

