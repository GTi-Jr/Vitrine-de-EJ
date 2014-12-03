# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: 'admin@example.com', password: '123456')
user.password = '123456'
user.function = "admin"
user.save

enterprise = JuniorEnterprise.create(name: 'Teste1')

enterprise = JuniorEnterprise.create(name: 'Teste2')

enterprise = JuniorEnterprise.create(name: 'Teste3')

enterprise = JuniorEnterprise.create(name: 'Teste4')

enterprise = JuniorEnterprise.create(name: 'Teste5')
enterprise = JuniorEnterprise.create(name: 'Teste6')

enterprise = JuniorEnterprise.create(name: 'Teste7')
enterprise = JuniorEnterprise.create(name: 'Teste8')
enterprise = JuniorEnterprise.create(name: 'Teste9')
enterprise = JuniorEnterprise.create(name: 'Teste10')

enterprise = JuniorEnterprise.create(name: 'Teste11')
enterprise = JuniorEnterprise.create(name: 'Teste12')
