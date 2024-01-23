from json import JSONEncoder

class Person:
    def __init__(self, title, name, surname):
        self.title = title
        self.name = name
        self.surname = surname

    def __str__(self):
        return f"{self.title} {self.name} {self.surname}"

class PersonJSONEncoder(JSONEncoder):
    def default(self, o):
        return o.__dict__
    
room_data = {
    'C101': {
        'occupants': [Person('Ms.', 'Serpil', 'Rüstemoğlu')],
        'purpose': 'İdari ve Mali İşler Daire Başkanı / Dir. Affaires Financieres',
        'temperature': 23.5,
        'humidity': 45
    },
    'C103': {
        'occupants': [
            Person('Mr.', 'Koray', 'Karahan'), 
            Person('Mr.', 'Kubilay', 'Arslan'), 
            Person('Mrs.', 'Semra', 'Güler'), 
            Person('Mrs.', 'Hatice', 'Karakuyu'), 
            Person('Mrs.', 'Hülya', 'Solak'), 
            Person('Mr.', 'Enes', 'Kocakel'), 
            ],
        'purpose': 'İdari ve Mali İşler Daire Başkanlığı',
        'temperature': 22.0,
        'humidity': 20
    },
    'C107': {
        'seats': 8,
        'occupants': [
            Person('Mr.', 'Göksel', 'Dinçer'),
            Person('Mr.', 'Ekrem', 'Kayaalp'), 
        ],
        'purpose': 'Yapı İşleri ve Teknoloji D. Başkanı',
        'temperature': 20.5,
        'humidity': 40
    },
    # 'C108': {
    #     'seats': 8,
    #     'purpose': 'Team meetings',
    #     'temperature': 20.5,
    #     'humidity': 40
    # },
    'C108': {
        'occupants': [Person('Mr.', 'Ali', 'Veli'), Person('Ms.', 'Efecan', 'Smith')],
        'purpose': 'Individual work',
        'temperature': 23.5,
        'humidity': 45
    },
    'C110': {
        'occupants': [
            Person('Dr.', 'Seyfullah', 'Günbattı'),
            Person('Mrs.', 'Afacan', 'Yılıverir'),
            Person('Mr.', 'Barış', 'Gülmez')],
        'purpose': 'Strateji geliştirme Daire Başkanlığı',
        'temperature': 22.0,
        'humidity': 20
    },
    #...

}