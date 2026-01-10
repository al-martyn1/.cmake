#!/bin/bash
sed -i -- 's/namespace public {/namespace public_ {/g' $1
sed -i -- 's/::public::/::public_::/g' $1
