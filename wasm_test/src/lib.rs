#[no_mangle]
pub extern "C" fn add(a: i32, b: i32) -> i32 {
    a + b
}

#[cfg(test)]
mod test {
    use crate::add;

    #[test]
    fn test_add() {
        let result = add(1, 2);
        assert_eq!(result, 3);
    }
}
