Name:       ee
Version:    0.0.0
Release:    2%{?dist}
Summary:    The command line interface for WordPress
License:    MIT
URL:        http://ee.org/
Source0:    ee.phar
Source1:    wp.1
BuildArch:  noarch

%post
echo "PHP 5.3.29 or above must be installed."

%description
EE is the command-line interface for WordPress.
You can update plugins, configure multisite installations
and much more, without using a web browser.

%prep
chmod +x %{SOURCE0}
{
    echo '.TH "WP" "1"'
    php %{SOURCE0} --help
} \
    | sed -e 's/^\([A-Z ]\+\)$/.SH "\1"/' \
    | sed -e 's/^  wp$/wp \\- The command line interface for WordPress/' \
    > %{SOURCE1}

%build

%install
mkdir -p %{buildroot}%{_bindir}
install -p -m 0755 %{SOURCE0} %{buildroot}%{_bindir}/wp
mkdir -p %{buildroot}%{_mandir}/man1
install -p -m 0644 %{SOURCE1} %{buildroot}%{_mandir}/man1/

%files
%attr(0755, root, root) %{_bindir}/wp
%attr(0644, root, root) %{_mandir}/man1/wp.1*

%changelog
* Tue Dec 12 2017 Murtaza Sarıaltun <murtaza.sarialtun@ozguryazzilim.com.tr> - 0.0.0-2
- Remove php requirements.
- Update creating man page steps.
- Added output message. 

* Fri Jul 7 2017 Murtaza Sarıaltun <murtaza.sarialtun@ozguryazilim.com.tr> - 0.0.0-1
- First release of the spec file
- Check the spec file with `rpmlint -i -v ee-rpm.spec`
- Build the package with `rpmbuild -bb ee-rpm.spec`
