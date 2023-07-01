
struct Character {
    var name: String
    var attack: () -> Void = {
        print("공격")
    }
    var healing: () -> Void = {
        print("치료")
    }
    
    init(name: String) {
        self.name = name
    }
    
    func tabShiftKey(skill: () -> Void) {
        return skill()
    }
}

var mango = Character(name: "mango")

mango.tabShiftKey(skill: mango.attack)
mango.tabShiftKey(skill: mango.healing)

extension Array {
    func myMap<T>(_ transform: (Element) -> T) -> Array<T> {
        var transformed: [T] = []
        
        for element in self {
            transformed.append(transform(element))
        }
        
        return transformed
    }
    
    func myFilter(_ isIncluded: (Element) -> Bool ) -> Self {
        var filtered: [Element] = []
        
        for element in self {
            if isIncluded(element) {
                filtered.append(element)
            }
        }
        
        return filtered
    }
    
    func myReduce<T>(_ initialResult: T, _ nextPartialResult: (T, Element) -> T) -> T {
        var reduced: T = initialResult
        
        for element in self {
            reduced = nextPartialResult(reduced, element)
        }
        
        return reduced
    }
}
