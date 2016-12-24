use strict;
use warnings;

use CertChecker;

my $app = CertChecker->apply_default_middlewares(CertChecker->psgi_app);
$app;

