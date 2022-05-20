# This function returns the value to the supplied key as mentioned in below test cases
def read_obj(objectn,keyn):
    all_keys=keyn.split("/")
    print(all_keys)
    for key in all_keys:
        res=objectn[key]
        objectn=res
    return res
    #print("res is --> {}".format(res))
    #print("key is --> {}".format(key))



##### Test 1 --> first object ####
object1 = {"a":{"b":{"c":"d"}}}
key1="a/b/c"
print("Value would be --> {}".format(read_obj(object1,key1)))

### Test 2 --> second object ###
object2 = {"x":{"y":{"z":"a"}}}
key2="x/y/z"
print("Value would be --> {}".format(read_obj(object2,key2)))