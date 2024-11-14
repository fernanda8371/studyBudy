// ModulesModel.swift

import Foundation

struct Subject: Hashable, Identifiable {
    let name: String
    let id = UUID()
}

struct SubjectCategory: Identifiable {
    let name: String
    let subjects: [Subject]
    let id = UUID()
}

let subjectCategories: [SubjectCategory] = [
    SubjectCategory(name: "Matemática",
                    subjects: [Subject(name: "Matemáticas"),
                               Subject(name: "Geometría"),
                               Subject(name: "Calcúlo"),
                               Subject(name: "Estadística")]),
    SubjectCategory(name: "Ciencia",
                    subjects: [Subject(name: "Biología"),
                               Subject(name: "Química"),
                               Subject(name: "Física"),
                               Subject(name: "Ciencia Ambiental")]),
    SubjectCategory(name: "Humanidades",
                    subjects: [Subject(name: "Historia"),
                               Subject(name: "Geografía"),
                               Subject(name: "Psicología"),
                               Subject(name: "Filosofía")]),
    SubjectCategory(name: "Idiomas",
                    subjects: [Subject(name: "Inglés"),
                               Subject(name: "Español"),
                               Subject(name: "Frances"),
                               Subject(name: "Aleman")])
]

