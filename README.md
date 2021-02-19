# Coding Challenge for Ruby Backend Developer

## `Image Fetcher`

Given a plaintext file containing URLs, one per line, e.g.:

```
http://mywebserver.com/images/271947.jpg
http://mywebserver.com/images/24174.jpg
http://somewebsrv.com/img/992147.jpg
```

Please write a command line script that takes this plaintext file as an
argument and downloads all images, storing them on the local hard disk.

## Implementation

### Project Organization

```
├───bin
│       image_fetcher.rb — main script for image fetching
├───lib
│       image_downloader.rb — service responsible for fetching the images
│       image_url_validator.rb — service responsible for image URL validation
│       url_file_reader.rb — service responsible for working with argument file
└───spec
    │
    ├───fixtures
    │       empty.txt — empty argument file
    │       links.txt — argument file with different links
    └───lib
            image_url_validator_spec.rb
            url_file_reader_spec.rb
```

### How to Run `Image Fetcher`

* `ruby bin/image_fetcher.rb ARG_FILE`

or

* `chmod +x bin\image_fetcher`
* `bin/image_fetcher ARG_FILE`

where `ARG_FILE` can be any file on the disk.

For test purposes you can use `spec/fixtures/links.txt`:
`bin/image_fetcher.rb spec/fixtures/links.txt`

The sample output goes as follows:

```
Image Fetcher processed URLs as follows:
Downloaded:         2
Invalid:            3
Valid yet failed:   0
```

### How to Test `Image Fetcher`

Just execute the `rspec` command from the base directory.

### Open Issues & Proposals

* Indicate directory where to save the images through the script arguments
* TBD

## Contributing

...

## License

...
