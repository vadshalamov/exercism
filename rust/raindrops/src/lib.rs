pub fn raindrops(n: u32) -> String {
    match (n % 3, n % 5, n % 7) {
        (0, 0, 0) => String::from("PlingPlangPlong"),
        (0, _, 0) => String::from("PlingPlong"),
        (0, 0, _) => String::from("PlingPlang"),
        (_, 0, 0) => String::from("PlangPlong"),
        (0, _, _) => String::from("Pling"),
        (_, 0, _) => String::from("Plang"),
        (_, _, 0) => String::from("Plong"),
        (_, _, _) => n.to_string(),
    }
}
