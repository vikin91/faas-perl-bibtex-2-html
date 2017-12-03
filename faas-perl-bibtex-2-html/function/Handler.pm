package Handler;
use strict;
use warnings;
use BibStyleConverter;
use Try::Tiny;

sub handle {
    my $st = shift;
    return HandleBibtex($st);
}

sub HandleBibtex {
  my $input = shift;
  my $conv = BibStyleConverter->new;
  my $bst = File::Spec->rel2abs( 'function/default.bst');
  my ($html, $warnings) = generate_html($bst, $input, $conv);
}

sub generate_html {
  my $bst_file  = shift;
  my $bib = shift;
  my $converter = shift;

  return ("", "ERROR: Bibtex-Html converter is not defined") unless $converter;
  return ("", "ERROR: Input missing") unless $bib;
  return ("", "ERROR: Template file not provided or not available under $bst_file") if !$bst_file or ! -e $bst_file;
  my $html;
  my $warnings;

  try {
    $converter->convert($bib, $bst_file);
    $html = $converter->get_html;
    $warnings = join(', ', $converter->get_warnings);
  }
  catch {
    $warnings = "WARNING: Converter was unable to convert this entry. Error: $_";
  };

  return ($html, $warnings);
}

1;
