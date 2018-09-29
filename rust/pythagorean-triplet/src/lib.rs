pub fn find() -> Option<u32> {
    let total = 1000;

    for a in 1..(total / 3) {
        for b in (a + 1)..(total / 2) {
            let c = total - a - b;

            if u32::pow(a, 2) + u32::pow(b, 2) == u32::pow(c, 2) {
                return Some(a * b * c);
            }
        }
    }

    None
}
