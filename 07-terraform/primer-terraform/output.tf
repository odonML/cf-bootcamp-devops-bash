output "filename_foo" {
  value = local_file.foo.filename
  description = "file name of foo file"
}

output "filename_drink" {
  value = local_file.drink.filename
  description = "file name of drink file"
}