Describe Get-ComputerInfo {
    Context " Check some services" {
        it " Should have the RPC service running "{
            $service = get-service RpcSs
            $service.Status | should -Be "running"
        }

        it " Should have MS Update Health Service  "{
            $service = Get-Service uhssvc
            $service.Status | should -Be "running"
        }

        it " Should have Windows Update Service  "{
            $service = Get-Service wuauserv
            $service.Status | should -not -Be "running"
        }
    }

    context " Check some files"{
        it " Should have a log file" {
            test-path "C:\Windows\Logs\StorGroupPolicy.log" | should -BeTrue  
        }

        it " Should have some information in a text file" {
            "C:\Windows\Logs\StorGroupPolicy.log" | Should -FileContentMatch "^*1008$"
        }
    }

    context " Check a web page status"{
        it  " Should return a 200 on when testing this web page" {
            $results = Invoke-WebRequest -Uri "https://google.com"
            $results.StatusCode | Should -BeExactly "200"
        }

    } 

}