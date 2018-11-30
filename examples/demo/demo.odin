package test

import "core:fmt"
import "core:mem"

main :: proc() {

    Bar :: struct {
        x: i32, // switch to i64 to fix `kind = nil`
    }

    Foo :: struct {
        position: [3]f32,
        user_handle: int,
        kind: union {
            Bar,
        },
    }

    foo: Foo;
    foo_ptr: ^Foo;
    // foo = Foo{{1, 2, 3}, 24, nil}; foo.kind = Bar{22};
    foo_ptr = &Foo{{1, 2, 3}, 24, Bar{22}};
    foo = foo_ptr^;
    fmt.println_err(u64(uintptr(foo_ptr)), "r1");
    foo_ptr_tag := (^i32)(uintptr(foo_ptr)+offset_of(Foo, kind)+size_of(Bar))^;
    fmt.println_err(foo_ptr_tag);
    foo_ptr_tag = (^i32)(uintptr(&foo)+offset_of(Foo, kind)+size_of(Bar))^;
    fmt.println_err(foo_ptr_tag);
    // fmt.println(u64(uintptr(foo_ptr)+offset_of(Foo, kind)+size_of(Bar)), "r2");

    // fmt.println(foo);
    // // fmt.println(data);
    // // fmt.println("predicted:");
    // // fmt.println("size_of   union", size_of(type_of(foo)));
    // // fmt.println("align_of  union", align_of(type_of(foo)));

    // raw_bar := (^Bar)(uintptr(&foo)+offset_of(Foo, kind))^;
    // tag_ptr := (^i32)(uintptr(&foo)+offset_of(Foo, kind)+size_of(Bar));
    // tag := tag_ptr^;
    // fmt.println(u64(uintptr(&tag_ptr)), "r");
    // fmt.println(raw_bar);
    // fmt.println(tag);
    // if raw_bar.x != 0 {
    //     assert(tag == 1);
    // }
}
