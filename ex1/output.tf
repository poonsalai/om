output "vpc_name" {
    value = data.aws_vpc.selected.id
}

output "subnet_ids" {
    value = data.aws_subnet_ids.ex1_subnet_ids.ids
}

output "target_group" {
    value = aws_lb_target_group.ex1.id
}