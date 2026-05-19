![](LOGO/aegys.png)

# Aegys

Rules generator.

## Installation

Install the [DMD 2 compiler](https://dlang.org/download.html) (using the MinGW setup option on Windows).

Build the executable with the following command line :

```bash
dmd -m64 aegys.d
```

## Usage

```
aegys <source_file_path> <source_file_configuration> [<source_file_path> <source_file_configuration> ...] <target_file_path>
```

## Example

```
aegys csharp_front_matter.md "" coding_standards.md "language=C# greenfield" OUT/coding-standards.mdc
```

## Version

0.1

## Author

Eric Pelzer (ecstatic.coder@gmail.com).

## License

This project is licensed under the GNU Lesser General Public License version 3.

See the [LICENSE.md](LICENSE.md) file for details.
