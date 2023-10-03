import Foundation

//{
//"id": "0",
//"title": "how do i install vs code",
//"tags": ["mac", "vs code"]
//},
struct Question: Codable, Hashable {
    let id: String
    let title: String
    let tags: [String]
}

//{
//"id": "sam5k",
//"tags": ["python", "networking"]
//},

struct Volunteer: Codable {
    var id: String
    let tags: [String]
}

struct DataObject: Codable {
    let questions: [Question]
    let volunteers: [Volunteer]
}


let json = """
    {
    "questions": [
    {
    "id": "0",
    "title": "how do i install vs code",
    "tags": ["mac", "vs code"]
    },
    {
    "id": "1",
    "title": "my program is too slow please help",
    "tags": ["python", "ai"]
    },
    {
    "id": "2",
    "title": "why is the hitbox off by 2 pixels",
    "tags": ["c#", "game"]
    },
    {
    "id": "3",
    "title": "my dependency injection stack trace is strange",
    "tags": ["java", "oop"]
    },
    {
    "id": "4",
    "title": "socket.recv is freezing",
    "tags": ["python", "networking"]
    },
    {
    "id": "5",
    "title": "i have a memory leak",
    "tags": ["c++", "networking"]
    }
    ],
    "volunteers": [
    {
    "id": "sam5k",
    "tags": ["python", "networking"]
    },
    {
    "id": "djpat",
    "tags": ["ai"]
    },
    {
    "id": "jessg",
    "tags": ["java", "networking"]
    },
    {
    "id": "rayo",
    "tags": ["java", "networking"]
    }
    ]
    }
"""

if let data = json.data(using: .utf8) {
    var dataObject: DataObject? = nil
    print(data.base64EncodedString())
    do {
        dataObject = try JSONDecoder().decode(DataObject.self, from: data)
    } catch {
        print("\(error.localizedDescription)")
    }
    
    if let object = dataObject {
        print(object.questions.count)
        buildAssingmentArray(object)
    }
    
}




// [Question: Vounteer]


//[
//    {'question': '1',
//    'volunteer': 'sam5k'}
//]

//{
//"id": "4",
//"title": "socket.recv is freezing",
//"tags": ["python", "networking"]
//},

//{
//"id": "jessg",
//"tags": ["java", "networking"]
//},

//{
//"id": "rayo",
//"tags": ["java", "networking"]
//}


func buildAssingmentArray(_ object: DataObject) {
    var assignmentDict: [Question: Volunteer] = [:]
    for question in object.questions {
        
        let tags = question.tags
        
        for volunteer in object.volunteers {
            
            let volunteerTags = volunteer.tags
            let matchingFlag = !tags.filter { volunteerTags.contains($0) }.isEmpty
            let existingVolunteer = !assignmentDict.values.filter { $0.id == volunteer.id }.isEmpty
            
            if matchingFlag &&  !existingVolunteer {
                assignmentDict[question] = volunteer
                break
            }
        }
    }
    
    print(assignmentDict.keys.map{ $0.id })
    print(assignmentDict.values.map{ $0.id })
}
