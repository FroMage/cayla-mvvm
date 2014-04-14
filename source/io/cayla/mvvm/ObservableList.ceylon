import ceylon.collection { LinkedList, MutableList }

"""An observable list that wraps a Ceylon mutable list. The observed list provides notifications for changes of the list itself, changes made to
   the elements themselves are not related to this observable object.
   
   When dependency tracking is active, accessing the list in read mode creates an implicit dependency on this observable.
   When the list is modified, subscribers of this observable will be notified.
   
   Keep in mind that the updating directly the underlying list will not broadcast any update. Likewise reading the underlying list
   will not affect dependency tracking.
   """
shared class ObservableList<Element>(
    "The mutable list"
    MutableList<Element> list = LinkedList<Element>())
        satisfies Observable<List<Element>> & MutableList<Element>
        given Element satisfies Object {

    value subscribers = Subscribers<List<Element>>();
    
    shared actual Subscription subscribe(Anything(List<Element>) subscriber) => subscribers.subscribe(subscriber);
    
    shared actual default Boolean equals(Object that) {
        // dependant.report(this);
        return (super of Identifiable).equals(that);
    }
    
    shared actual Integer hash {
        // dependant.report(this);
        return (super of Identifiable).hash;
    }
    
    shared actual MutableList<Element> clone() {
        dependant.report(this);
        return list.clone();
    }
    
    shared actual Element? get(Integer index) {
        dependant.report(this);
        return list.get(index);
    }
    
    shared actual Integer? lastIndex {
        dependant.report(this);
        return list.lastIndex;
    }
    
    shared actual List<Element> rest {
        dependant.report(this);
        return list.rest;
    }
    
    shared actual List<Element> reversed {
        dependant.report(this);
        return list.reversed;
    }
    
    shared actual List<Element> segment(Integer from, Integer length) {
        dependant.report(this);
        return list.segment(from, length);
    }
    
    shared actual List<Element> span(Integer from, Integer to) {
        dependant.report(this);
        return span(from, to);
    }
    
    shared actual List<Element> spanFrom(Integer from) {
        dependant.report(this);
        return spanFrom(from);
    }
    
    shared actual List<Element> spanTo(Integer to) {
        dependant.report(this);
        return spanTo(to);
    }
    
    shared actual void set(Integer index, Element val) {
        list.set(index, val);
        subscribers.notify(list);
    }
    
    shared actual void insert(Integer index, Element val) {
        list.insert(index, val);
        subscribers.notify(list);
    }
    
    shared actual void addAll({Element*} values) {
        list.addAll(values);
        subscribers.notify(list);
    }
    
    shared actual void remove(Element val) {
        list.remove(val);
        subscribers.notify(list);
    }
    
    shared actual void clear() {
        list.clear();
        subscribers.notify(list);
    }
    
    shared actual void add(Element element) {
        list.add(element);
        subscribers.notify(list);
    }
    
    shared actual Element? delete(Integer index) {
        value ret = list.delete(index);
        subscribers.notify(list);
        return ret;
    }
    
    shared actual List<Element> getValue() {
        return this;
    }
    
    shared actual void deleteSegment(Integer from, Integer length) {
        list.deleteSegment(from, length);
        subscribers.notify(list);
    }
    
    shared actual void deleteSpan(Integer from, Integer to) {
        list.deleteSpan(from, to);
        subscribers.notify(list);
    }
    
    shared actual void infill(Element replacement) {
        list.infill(replacement);
        subscribers.notify(list);
    }
    
    shared actual void prune() {
        list.prune();
        subscribers.notify(list);
    }
    
    shared actual void removeAll({Element*} elements) {
        list.removeAll(elements);
        subscribers.notify(list);
    }
    
    shared actual Boolean removeFirst(Element element){
        value ret = list.removeFirst(element);
        subscribers.notify(list);
        return ret;
    }
    
    shared actual Boolean removeLast(Element element) {
        value ret = list.removeLast(element);
        subscribers.notify(list);
        return ret;
    }
    
    shared actual void replace(Element element, Element replacement) {
        list.replace(element, replacement);
        subscribers.notify(list);
    }
    
    shared actual Boolean replaceFirst(Element element, Element replacement) {
        value ret = list.replaceFirst(element, replacement);
        subscribers.notify(list);
        return ret;
    }
    
    shared actual Boolean replaceLast(Element element, Element replacement) {
        value ret = list.replaceLast(element, replacement);
        subscribers.notify(list);
        return ret;
    }
    
    shared actual void truncate(Integer size) {
        list.truncate(size);
        subscribers.notify(list);
    }
    
}