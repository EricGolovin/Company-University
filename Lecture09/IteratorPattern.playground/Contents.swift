import Foundation

public struct Queue<T> {
    private var array: [T?] = []
    
    private var head = 0
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var count: Int {
        return array.count - head
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else {
            return nil
        }
        
        array[head] = nil
        
        head += 1
        
        return element
    }
}

extension Queue: Sequence {
    public func makeIterator() -> IndexingIterator<ArraySlice<T?>> {
        let nonEmptyValue = array[head..<array.count]
        return nonEmptyValue.makeIterator()
    }
}

public struct Ticket {
    var description: String
    var priority: PriorityType
    
    enum PriorityType {
        case low
        case medium
        case high
    }
    
    init(description: String, priority: PriorityType) {
        self.description = description
        self.priority = priority
    }
    
}

extension Ticket {
    var sortIndex: Int {
        switch self.priority {
        case .low:
            return 0
        case .medium:
            return 1
        case .high:
            return 2
        }
    }
}

var queue = Queue<Ticket>()

queue.enqueue(Ticket(description: "01", priority: .low))
queue.enqueue(Ticket(description: "02", priority: .medium))
queue.enqueue(Ticket(description: "03", priority: .high))
queue.enqueue(Ticket(description: "04", priority: .low))

queue.dequeue()

print("List of Tickets in queue:")
for ticket in queue {
    print(ticket?.description ?? "No Description")
}

let sortedTickets = queue.sorted {
    $0!.sortIndex > ($1?.sortIndex)!
}

var sortedQueue = Queue<Ticket>()

for ticket in sortedTickets {
    sortedQueue.enqueue(ticket!)
}

print("Tickets sorted by priority:")
printTickets(in: sortedQueue)


func printTickets<T>(in queue: Queue<T>) {
    if let queue = queue as? Queue<Ticket> {
        for ticket in queue {
            print(ticket?.description ?? "No Description")
        }
        return
    }
    print("Print type does not exists")
}
